src = File.expand_path(File.dirname(__FILE__))
installdest = RbConfig::CONFIG['sitelibdir']
File.write("Makefile", <<-END
.PHONY: all
SRC=#{src}
DEST=$(shell pwd)

all: $(wildcard $(SRC)/*.rs)
\t cd $(SRC) && cargo build --release && ([ ! -e "$(DEST)/target" ] && ln -s $(SRC)/target $(DEST)/target || true)
\t [ -e target/release/librustdown.dylib ] && mv target/release/librustdown.dylib librustdown.bundle || mv target/release/librustdown.* .

install:
\tls -l >&2
\tinstall librustdown.* #{installdest}
END
)

$stderr.puts(File.read("Makefile"))
