class Notifications < ActionMailer::Base

 def forgot_password(to, login, pass, sent_at = Time.now)
    @subject    = "Su contraseña es ..."
    @body['login']=login
    @body['pass']=pass
    @recipients = to
    @from       = 'support@yourdomain.com'
    @sent_on    = sent_at
    @headers    = {}
  end

end
