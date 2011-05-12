class DificultFactory
  DIFICULTS = {:easy => Dificult.new, :medium => MediumDificult.new, :hard => HardDificult.new }

  def self.get_dificult(dificult)
    DIFICULTS[dificult] || DIFICULTS[:hard]
  end
  
  def self.get_dificult_by_word(word)

    case word.length
      when (0...5) : DIFICULTS[:easy]
      when (6...10): DIFICULTS[:medium]
      else DIFICULTS[:hard]
    end     

  end
end
