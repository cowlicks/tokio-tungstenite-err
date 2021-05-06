# Taken from https://github.com/alexcrichton/rust-ffi-examples/tree/master/c-to-rust
#
ifeq ($(shell uname),Darwin)
    LDFLAGS := -Wl,-dead_strip
else
    LDFLAGS := -Wl,--gc-sections -lgcc_s -lutil -lrt -lpthread -lm -ldl -lc -lssl -lcrypto
endif

SRC := src
RS_SOURCES := $(wildcard $(SRC)/*.rs)

all: target/foo
	target/foo

target:
	mkdir -p $@

target/foo: target/main.o target/debug/libfoo.a
	$(CC) -o $@ $^ $(LDFLAGS)

target/debug/libfoo.a: $(RS_SOURCES) Cargo.toml
	cargo build

target/main.o: src/main.c | target
	$(CC) -o $@ -c $<

clean:
	rm -rf target
