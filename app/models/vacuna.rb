class Vacuna < ApplicationRecord
    belongs_to :dog
    validates :nombre, presence: true
    validates :fecha, presence: true


    validate :datetime_not_in_future
    
    validate :vacuna_no_duplicada

    private
  def datetime_not_in_future
    if fecha? && fecha > Time.now
      errors.add(:fecha, "no debe ser futura")
    end
  end

  def vacuna_no_duplicada
    if dog.vacuna.exists?(fecha: self.fecha, nombre: self.nombre)
      errors.add(:base, "Vacuna ya cargada")
    end
  end

end
