class CarAnnouncement < ApplicationRecord

  BRANDS = [ "Alfa Romeo", "Aston Martin", "Audi", "Bentley", "BMW",
    "Buick", "Cadillac", "Chery", "Chevrolet", "Chrysler",
    "Citroën", "Dacia", "Daewoo", "Daihatsu", "Dodge", "DS Automobiles",
    "Ferrari", "Fiat", "Ford", "Geely", "GMC", "Honda", "Hyundai",
    "Hummer", "Infiniti", "Isuzu", "Jaguar", "Jeep", "Kia", "Lada",
    "Lamborghini", "Lancia", "Land Rover", "Lexus", "Lincoln", "Lotus",
    "Maserati", "Mazda", "McLaren", "Mercedes - Benz", "Mini",
    "Mitsubishi", "Nissan", "Opel", "Peugeot", "Porsche", "Renault",
    "Seat", "Skoda", "Smart", "Ssangyong", "Subaru", "Suzuki", "Tata",
    "Tesla", "Toyota", "Volkswagen", "Volvo"].freeze


  has_one :announcement, as: :content, autosave: true, required: true, dependent: :destroy
  accepts_nested_attributes_for :announcement

  validates_presence_of :make
  validates_inclusion_of :make, in: BRANDS

  

end
