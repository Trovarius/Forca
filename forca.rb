class Forca
  @status = []
  @status_atual = []

  def initialize(palavra)
    configure_word(palavra)
    @status =  %W("cabeça corpo mãos pernas rosto")
    @status_atual = []
    output
  end
  
  def input(letra)
    if valid_letter(letra)
      replace_letter(letra)
    else
      adiciona_status()
    end

    output
  end

  def output
    if @jogo[:exibicao] == @jogo[:palavra] || @status == @status_atual
      puts "Seu Jogo terminou tente novamente"
    else
      puts "Letras conseguidas : #{@jogo[:exibicao].to_s}"
      puts ""
      puts "Status:#{@status_atual.join(' ')}"
      puts ""
      puts "Quantidade de Chances: #{@status.length - @status_atual.length}"
    end
  end
   
  def adiciona_status()
    @status_atual << @status[@status_atual.length]
  end

private 
  def configure_word(word)
    @jogo = { :palavra => word.split(//), :exibicao => word.gsub(/\w/, '?').split(//)}
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

