require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "423612321079-tshgt8kq0tjrkbihujd65vl56vn9ep4n.apps.googleusercontent.com",
  "BlinQpZmL_kP95Xo4d9Kek9c"
end
