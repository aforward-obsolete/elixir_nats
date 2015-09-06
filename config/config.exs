use Mix.Config

# Example configurations only, and this file WILL NOT be loaded by your application
# If you are using plain text passwords, please do not commit this file to your repo
# config :nats, Nats.Connection,
#   url: "mynatsserver.com",
#   port: 4222,
#   verbose: true,
#   pedantic: false,
#   user: "aforward",
#   password: "nicetry"

if File.exists?("#{Mix.env}.exs") do
  import_config "#{Mix.env}.exs"
end
