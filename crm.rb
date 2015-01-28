require 'sinatra'
require './contact'
require './rolodex'

$rolodex = Rolodex.new

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


post '/contacts' do
	@title = "Contacts"
	contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(contact)
	redirect to('/contacts')
end

