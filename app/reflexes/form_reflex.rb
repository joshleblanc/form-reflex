# frozen_string_literal: true

class FormReflex < ApplicationReflex
  include Optimism

  before_reflex do |reflex|
    # Handle change keeps the session[:model] object up to date with what's going on in the form.
    # We need to track changes in order to reconcile what fields_for fields we're deleting, as
    # well as performing validation on change
    if reflex.method_name == "handle_change"
      model = session[:model]

      # validation_path will be passed to broadcast_errors
      # It's a hash built to mimic safe params you would pass in the controller
      # so given a name foo[bar][0][id], we will build
      # {
      #   "foo": {
      #     "bar": {
      #       "0": {
      #         id: nil
      #       }
      #     }
      #   }
      # }
      validation_path = {}
      validation_ptr = validation_path

      # Similar to the validation path, we need to locate the child model we want to modify
      # when working with fields_for. So following the example above, we start with the `Foo` model,
      # but we want to end up with the first `Bar` child.
      name_parts = element[:name].scan(/\[(.+?)\]/).flatten
      name_parts[0...name_parts.length - 1].each do |part|
        validation_ptr[part] ||= {}
        validation_ptr = validation_ptr[part]
        part.chomp! '_attributes'
        if safe?(model, part) && model.respond_to?(part)
          model = model.send part
        elsif model.respond_to? '[]'
          model = model.send '[]', part.to_i
        end
      end

      validation_ptr[name_parts.last] = nil

      if element[:type] == "checkbox"
        model.send "#{name_parts.last}=", element[:checked]
      else
        model.send "#{name_parts.last}=", element[:value]
      end

      model.validate
      broadcast_errors(session[:model], validation_path)
      throw :abort
    end
  end

  def current_user
    controller.current_user
  end

  # The add button declares what association to add with data-association
  def association
    a = element.dataset[:association]
    # send is spoopy, make sure the message you're sending is actually an association
    return unless safe?(session[:model], a)

    session[:model].send(a)
  end

  # We need to determine if we're `send`ing a safe message to the model
  # We don't want someone to modify the name of an html element and send `destroy!` for example
  def safe?(model, thing)
    safe = false
    safe ||= !model.association(thing).nil? if model.respond_to?('association')
    if model.respond_to? 'attributes'
      safe ||= model.attributes.keys.include?(thing)
    end
    safe
  end

  # Creates a new, empty association.
  def add
    association.build
  end

  # Removes an unsaved association. This for for the use case where the user has added a new
  # association, hasn't saved the form yet, and wants to remove the un-saved association.
  def delete
    association.delete association[element.dataset[:index].to_i]
  end

  def handle_change
    # stub
  end
end
