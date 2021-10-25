module SpreeGoshippo
  module ShipmentSerializerDecorator
    def self.prepended(base)

      base.attributes :tracking
    end
  end
end

Spree::V2::Storefront::ShipmentSerializer.prepend(SpreeGoshippo::ShipmentSerializerDecorator)