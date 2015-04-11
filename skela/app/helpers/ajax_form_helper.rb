module AjaxFormHelper
  def ajax_string(field, resource = @resource)
    ajax_form 'string', resource, field
  end

  def ajax_text(field, resource = @resource)
    ajax_form 'text', resource, field
  end

  def ajax_number(field, resource = @resource)
    ajax_form 'number', resource, field
  end

  def ajax_price(field, resource = @resource)
    ajax_form 'price', resource, field
  end

  def ajax_user_select(field, resource = @resource)
    ajax_form 'user_select', resource, field
  end

  def ajax_boolean(field, resource = @resource)
    ajax_form 'boolean', resource, field
  end

  def ajax_datetime(field, resource = @resource)
    ajax_form 'datetime', resource, field
  end

  def ajax_form(type, resource, field)
    klass = type
    form_for resource, html: { id: "edit_issue_#{field}", class: klass}, remote: true do |f|
      if type == 'user_select'
        user_select f, field
      elsif type == 'number'
        f.number_field field, class: 'ajax_field'
      elsif type == 'string'
        f.text_field field, class: 'ajax_field'
      elsif type == 'text'
        f.text_area field, class: 'ajax_field'
      elsif type == 'boolean'
        (f.label field) + (f.check_box field, class: 'ajax_field')
      elsif type == 'datetime'
        f.date_select field, class: 'ajax_field'
      elsif type == 'price'
        f.text_field field, class: 'ajax_field', value: number_with_precision(resource.send(field), precision: 2)
      end
    end
  end

  def user_select(form_builder, field)
    form_builder.select field, options_for_select(User.all.map { |user| [user.username, user.id.to_s]}, @issue.send(field)), { include_blank: true }, { class: 'ajax_field' }
  end

  def updated_field_at(field, object, options = {})
    klass = 'updated_at'
    klass << ' invisible' if options[:cloaked]
    content_tag :span, data: { field: field, id: object.id }, class: klass do
      if object.send field
      'updated: ' + object.send(field).in_time_zone('Eastern Time (US & Canada)').strftime('%B %e, %Y at %l:%M:%S %p')
      end
    end
  end
end
