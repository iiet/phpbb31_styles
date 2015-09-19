#!/bin/bash
uglifyjs --compress --mangle -o template/forum_fn.js -- template/forum_fn.js.to_m
uglifyjs --compress --mangle -o template/ajax.js -- template/ajax.js.to_m
