class HouseholdAppliancesAnnouncement < ApplicationRecord

  BRANDS = ["AEG", "Altus", "Arçelik", "Beko", "Bosch", "Electrolux",
    "Ferre", "Finlux", "Franke", "Grundig", "Hoover", "Hoover",
    "Hotpoint Ariston", "ICF", "Indesit", "Kumtel", "LG", "Liebherr",
    "Profilo", "Regal", "Samsung", "Siemens", "Silverline", "Simfer",
    "Termikel", "Vestel", "Vestfrost"].freeze


  has_one :announcement, as: :content, autosave: true, required: true, dependent: :destroy
  accepts_nested_attributes_for :announcement

  validates_presence_of :make
  validates_inclusion_of :make, in: BRANDS

end
