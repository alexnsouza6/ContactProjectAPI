class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]


  # GET /contacts
  def index
    @contacts = Contact.all

    #render json: @contacts => @contacts.as_json.to_json => as_json: vira hash, to_json: vira string (JSON)
    #only: e except:
    #@contacts.map { |contact| contact.attributes.merge({author: "SIX"})}
    render json: @contacts, include: :kind
  end

  # GET /contacts/1
  def show
    render json: @contact, include: [:kind, :phones]
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, include: [:kind, :phones], status: :created, location: @contact
    else
      render json: {errors: @contact.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    #For nested attributes, user MUST pass the ID to update an object in POSTMAN
    if @contact.update(contact_params)
      render json: @contact, include: [:kind, :phones]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    #To destroy an object, user MUST pass the attribute "_destroy" and the ID
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :email, :birthdate, :kind_id, phones_attributes: [:id, :number, :_destroy])
    end
end
