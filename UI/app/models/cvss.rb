class Cvss < ActiveRecord::Base
  set_table_name "cvss"

  attr_accessible :id, :gen_date, :score, :access_vector, :access_complexity, :authentication, :conf_impact, :integrity_impact, :availability_impact, :source

  has_many :devices, :class_name => "DviVuln", :foreign_key => "vuln_id"

end
