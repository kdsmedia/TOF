var file = File.new()

func read(path):
    if not file.file_exists(path):
        self.write(path, {'is_ok' : 1})

    var err = file.open(path, File.READ)
    if err != OK:
        return {}

    var data = file.get_var()
    file.close()

    return data

func write(path, data):
    var err = file.open(path, File.WRITE)
    if err != OK:
        return

    file.store_var(data)
    file.close()

func file_exists(path):
    return file.file_exists(path)