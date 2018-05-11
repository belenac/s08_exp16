input = 0
while input
  puts 'Ingrese una opción'
  puts 'Ingrese 1 para ver el promedio de notas'
  puts 'Ingrese 2 para ver las inasistencias del curso'
  puts 'Ingrese 3 para ver los alumnos aprobados'
  puts 'Ingrese 4 para salir del programa'

  input = gets.chomp.to_i
  case input
  when 1
    # Opcion 1: Debe generar un archivo con el nombre de cada alumno y el promedio de sus notas.
    notas = File.open('curso.csv', 'r').readlines
    notas.map do |elem|
      data = elem.split(', ').map { |e| e.chomp }
      notas_alumno = data[1..5].delete_if { |e| e == 'A' }
      notas_decimales = notas_alumno.map { |e| e.to_f }
      suma_notas = notas_decimales.inject(0) { |sum, num| sum + num }
      promedio = suma_notas / notas_decimales.count
      File.open('promedio_alumnos.txt', 'a') { |file| file.puts "El alumno #{data[0]} tiene un promedio de #{promedio}" }
    end
    puts "Se ha creado un archivo llamado promedio_alumnos.txt en su directorio.\n"
  when 2
    # Opcion 2: Debe contar la cantidad de inasistencias totales y mostrarlas en pantalla.
    asistencia = File.open('curso.csv', 'r').readlines
    asistencia.map do |elem|
      info = elem.split(', ').map { |e| e.chomp }
      alumno = info[0]
      faltas = info.select.count { |n| n == 'A' }
      if faltas.zero?
        puts "El alumno #{alumno} no ha faltado a evaluaciones."
      elsif faltas == 1
        puts "El alumno #{alumno} ha faltado a #{faltas} evaluación."
      else
        puts "El alumno #{alumno} ha faltado a #{faltas} evaluaciones."
      end
    end
  when 3
    # Opcion 3: Debe mostrar los nombres de los alumnos aprobados.
    def status_alum(nota_promedio)
      notas = File.open('curso.csv', 'r').readlines
      notas.map do |elem|
        data = elem.split(', ').map { |e| e.chomp }
        notas_alumno = data[1..5].delete_if { |e| e == 'A' }
        notas_decimales = notas_alumno.map { |e| e.to_f }
        suma_notas = notas_decimales.inject(0) { |sum, num| sum + num }
        promedio = suma_notas / notas_decimales.count
        if promedio <= nota_promedio
          puts "El alumno #{data[0]} reprobo con promedio #{promedio}"
        else
          puts "El alumno #{data[0]} aprobo con promedio #{promedio}"
        end
      end
    end
    status_alum(5.0)
  when 4
    # Opcion 4: Terminar el programa.
    puts 'Adiós.'
    exit
  else
    puts 'Ingrese una opción valida'
  end
end
