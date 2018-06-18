class SignInFailure < Devise::FailureApp

  def scope_url
    if request.referrer.include?("ann_created")
      request.referrer
    else
      super
    end
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end