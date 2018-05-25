module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    render 'form_errors', object: resource
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end