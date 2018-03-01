class PictureMailer < ApplicationMailer
  def picture_mail(picture)
   @picture = picture

   mail to: "shuji_tominaga@diveintocode.jp", subject: "お問い合わせの確認メール"
  end
end
