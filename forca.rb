class Forca
  
  def initialize(palavra = "", dificult = :easy)
    configure_word(palavra)
    configure_dificult(dificult)
    output
  end
  
  def input(letra)
    if valid_letter(letra)
      replace_letter(letra)
    else
      @dificult.add_status
    end

    output
  end

  def output
    if @jogo[:exibicao] == @jogo[:palavra] || !@dificult.can_try?
      puts "Seu Jogo terminou tente novamente"
    else
      puts "Letras conseguidas : #{@jogo[:exibicao].to_s}"
      puts ""
      puts "Status:#{@dificult.to_s}"
      puts ""
      puts "Quantidade de Chances: #{@dificult.number_of_chances}"
    end
  end
   
private 
  def configure_word(word)
    @jogo = { :palavra => word.split(//), :exibicao => word.gsub(/\w/, '?').split(//)}
  end

  def configure_dificult()
    @dificult = DificultFactory.get_dificult(
  end

  def valid_letter(letra)
    return (letra.length == 1) && (!(letra =~ /\w/).nil?) && (@jogo[:palavra].include? letra)
  end

  def replace_letter(letra)
    @jogo[:palavra].each_index do |index|
      @jogo[:exibicao][index] = letra if @jogo[:palavra][index].downcase == letra.downcase
    end
  end
end




class Dificult
  @status = []
  @actual_status = []

  def initialize
    @status = %W("cabeça corpo mãos pernas rosto")
  end 
  
  def add_status
    @actual_status << @status[@actual_status.length]
  end

  def can_try?
    number_of_chances > 0
  end
  
  def number_of_chances()
    @status.length - @actual_status.length
  end
  
  def to_s
     @actual_status.join(' ')
  end
end


class MediumDificult < Dificult
  def initialize
      @status = %W("cabeça corpo resto")
      @actual_status = []
  end  
end

class HardDificult < Dificult
  def initialize
    @status = %W("cabeça corpo")
    @actual_status = []
  end  
end

class DificultFactory
  @dificults = {:easy => Dificult.new, :medium => MediumDificult.new, :hard => HardDificult.new }

  def self.get_dificult(dificult)
    @dificults[dificult] || @dificults[:hard]
  end
  
  def self.get_dificult_by_word(word)

    case word.size
      when 0..5: @dificults[:easy]
      when 6..10: @dificults[:medium]
      else @dificults[:hard]
    end     

  end
end
