src = File.expand_path(File.dirname(__FILE__))

File.write("Makefile", <<-END
.PHONY: all
SRC=#{src}
DEST=$(shell pwd)

all: $(wildcard $(SRC)/*.rs)
\t cd $(SRC) && cargo build --release && mv target $(DEST)
\t mv target/release/librustdown.dylib librustdown.bundle
#\tclang -dynamic -bundle -o librustdown.bundle target/release/librustdown.dylib
END
)
