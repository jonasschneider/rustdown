src = File.expand_path(File.dirname(__FILE__))
installdest = RbConfig::CONFIG['sitelibdir']
File.write("Makefile", <<-END
.PHONY: all
SRC=#{src}
DEST=$(shell pwd)

all: $(wildcard $(SRC)/*.rs)
\t cd $(SRC) && cargo build --release && ([ "$(SRC)" = "$(DEST)" ] && true || ln -s $(SRC)/target $(DEST)/target)
\t [ -e target/release/librustdown.dylib ] && mv target/release/librustdown.dylib librustdown.bundle || mv target/release/librustdown.* .

install:
\tinstall librustdown.* #{installdest}
END
)
