require 'sinatra'
require './contact'
require './rolodex'

$rolodex = Rolodex.new

$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

contact = $rolodex.find(1000)

get '/' do
	@crm_name = "My CRM"
	@title = "Sinatra"
	erb :index
end

get '/contacts' do 
	@contacts = $rolodex.contacts
	erb :contacts
end

get '/contacts/new' do
	@title = "New Contact"
	erb :new
end

get "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
  	erb :show_contact
	else
		raise Sinatra::NotFound 
	end
end

post '/contacts' do
	@title = "Contacts"
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end

