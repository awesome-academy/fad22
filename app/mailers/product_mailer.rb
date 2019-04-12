class ProductMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.product_mailer.product_deleted.subject
  #
  def product_deleted product, orders
    @product = product
    @orders = orders
    mail to: "huatam391@gmail.com",
      subject: "Warning exist orders with product was deleted"
  end
end
