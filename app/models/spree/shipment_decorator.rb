module Spree
  module ShipmentDecorator
  	def update_amounts
      if selected_shipping_rate
        require 'shippo'
        require 'awesome_print'

        Shippo::API.token = ENV['GOSHIPPO_API_KEY']

        $shipment_rate = nil
        for item in line_items do
	      params   = {  async:          false,
	                    address_from:   {
	                      name:           stock_location.name,
	                      company:        stock_location.admin_name,
	                      street1:        stock_location.address1,
	                      street2:        stock_location.address2,
	                      city:           stock_location.city,
	                      state:          stock_location.state.abbr,
	                      zip:            stock_location.zipcode,
	                      country:        stock_location.country.iso,
	                      phone:          stock_location.phone },
	                    address_to:     {
	                      name:           address.firstname,
	                      company:        address.company,
	                      street1:        address.address1,
	                      city:           address.city,
	                      state:          address.state.abbr,
	                      zip:            address.zipcode,
	                      country:        address.country.iso,
	                      phone:          address.phone,
	                      email:          order.email },
	                    parcels:         {
	                      length:        item.variant.depth,
	                      width:         item.variant.width,
	                      height:        item.variant.height,
	                      distance_unit: :in,
	                      weight:        item.variant.weight,
	                      mass_unit:     :lb }
	                  } 

	       @shipment = Shippo::Shipment.create(params)
  	         for rate in @shipment.rates do
	           if rate.attributes.present?
	             if rate.attributes.first == "BESTVALUE"
	           	   $shipment_rate = $shipment_rate.to_f + rate.amount.to_f
	               break
	             end
	           end
	         end

        end 

        unless $shipment_rate.nil? 
          update_columns(
		           cost: $shipment_rate,
		           adjustment_total: adjustments.additional.map(&:update!).compact.sum,
		           updated_at: Time.current
		          )

   		end

        
      end
    end

   Spree::Shipment.prepend Spree::ShipmentDecorator
  end
end