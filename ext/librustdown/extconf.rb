src = File.expand_path(File.dirname(__FILE__))
installdest = RbConfig::CONFIG['sitelibdir']
File.write("Makefile", <<-END
.PHONY: all
SRC=#{src}
DEST=$(shell pwd)

all: $(wildcard $(SRC)/*.rs)
\t cd $(SRC) && cargo build --release && ([[ "$(SRC)" = "$(DEST)" ]] && true || ln -s $(SRC)/target $(DEST)/target)
\t mv target/release/librustdown.dylib librustdown.bundle
#\tclang -dynamic -bundle -o librustdown.bundle target/release/librustdown.dylib

install:
\tinstall librustdown.bundle #{installdest}
END
)
