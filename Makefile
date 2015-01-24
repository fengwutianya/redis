all: testdeps
	go test ./... -v 1 -ginkgo.slowSpecThreshold=10 -cpu=1,2,4
	go test ./... -ginkgo.slowSpecThreshold=10 -short -race

test: testdeps
	go test ./... -v 1 -ginkgo.slowSpecThreshold=10

testdeps: .test/redis/src/redis-server

.PHONY: all test testdeps

.test/redis:
	mkdir -p $@
	wget -qO- https://github.com/antirez/redis/archive/3.0.tar.gz | tar xvz --strip-components=1 -C $@

.test/redis/src/redis-server: .test/redis
	cd $< && make all
