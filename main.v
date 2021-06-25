import time
import net.http
import math
import os

fn task(url string) {
	link := os.args[1]
	start := time.now()
	http.get(url) or {}
	latency := time.now() - start
	println('${link} | ${math.round(latency/1000000)}ms')
}

fn main() {
	for {
		if os.args.len >= 3 {
			break
		}
		else {
			println("Required arguments \"url\" and \"threads\".")
			exit(1)
		}
	}
	thread_count := os.args[2].int()
	link := os.args[1]
	for {
		mut threads := []thread{}
		for {
			mut i := 0
			if i < thread_count {
				i = i++
				threads << go task(link)
			}
			else {
				break
			}
		}
		threads.wait()
	}
}
