package main

import "core:fmt"
import "core:os"
import "core:strings"
import "days"

main :: proc() {
	basePath := strings.join({os.get_current_directory(), "inputs"}, "/")
	days.runDay1(basePath)
}
