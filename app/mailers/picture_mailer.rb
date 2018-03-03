class PictureMailer < ApplicationMailer
  def picture_mail(picture)
   @picture = picture

   mail to: "shuji_tominaga@diveintocode.jp", subject: "投稿確認メールざます！！＾＾"
  end
end
