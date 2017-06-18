module Identity
  def identity_form(user)
    if user.investor.nil?
      user.build_investor
    end
    identity = user.investor.build_investor_identity
    identity.attachments.build
    identity
  end
end
