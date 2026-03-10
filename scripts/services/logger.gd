const PATH = 'res://logs/log.txt'

var file = File.new()
var dir = Directory.new()

func _init():
    self.__ensure_dir_exists()
    self.__create_file_if_no_exists()

func store(data):
    var err = file.open(self.PATH, File.READ_WRITE)
    if err != OK:
        print("Error opening log file: ", err)
        return

    file.seek_end()
    var date = OS.get_datetime()
    var date_str = "[%02d-%02d-%02d %02d:%02d:%02d] " % [date['day'], date['month'], date['year'], date['hour'], date['minute'], date['second']]
    file.store_line(date_str + data)
    file.close()

func __ensure_dir_exists():
    var dir_path = PATH.get_base_dir()
    if not dir.dir_exists(dir_path):
        dir.make_dir_recursive(dir_path)

func __create_file_if_no_exists():
    if not file.file_exists(self.PATH):
        var err = file.open(self.PATH, File.WRITE)
        if err != OK:
            print("Error creating log file: ", err)
            return
        file.close()