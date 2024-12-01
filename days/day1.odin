package days

import "core:fmt"
import "core:math"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

runDay1 :: proc(basePath: string) {
	test := "day1test.txt"
	actual := "day1.txt"

	data, ok := os.read_entire_file(strings.join({basePath, actual}, "/"), context.allocator)
	if !ok {
		fmt.panicf("file not found")
	}

	defer delete(data, context.allocator)

	firstCol := [dynamic]int{}
	secCol := [dynamic]int{}
	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		chars := strings.split(strings.trim_space(line), "   ")
		append(&firstCol, strconv.atoi(chars[0]))
		append(&secCol, strconv.atoi(chars[1]))
	}
	slice.sort(firstCol[:])
	slice.sort(secCol[:])
	sum := 0
	for i in 0 ..< len(firstCol) {
		sum += math.abs(firstCol[i] - secCol[i])
	}
	fmt.println("Part1: ", sum)

	multi := make(map[int]int)
	defer delete(multi)

	for num in secCol {
		elem, ok := multi[num]
		if !ok {
			multi[num] = 1
		} else {
			multi[num] = elem + 1
		}
	}

	sumagain := 0
	for num in firstCol {
		multiplier, ok := multi[num]
		if ok {
			sumagain += num * multiplier
		}
	}
	fmt.println("Part2: ", sumagain)
}
