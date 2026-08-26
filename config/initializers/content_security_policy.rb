# Be sure to restart your server when you modify this file.

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https, "https://challenges.cloudflare.com"
    policy.style_src   :self, :https
    policy.frame_src   :self, "https://challenges.cloudflare.com"
  end

  config.content_security_policy_report_only = true
end
