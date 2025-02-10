checkstyle:
	./gradlew checkstyle

javadoc:
	# Output is (module)/build/docs/javadoc/release
	./gradlew library:javadocrelease

test:
	./gradlew :library:test -i

release:
	./gradlew :library:assembleRelease

local-publish:
	./gradlew publishToMavenLocal


prepare-publish: javadoc local-publish checksums
	@echo "All files are prepared for publishing"

checksums:
	cd ~/.m2/repository/io/github/track-asia/trackasia-android-gestures/2.0.2/ && \
	md5sum trackasia-android-gestures-2.0.2.pom | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2.pom.md5 && \
	md5sum trackasia-android-gestures-2.0.2.aar | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2.aar.md5 && \
	md5sum trackasia-android-gestures-2.0.2-sources.jar | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2-sources.jar.md5 && \
	md5sum trackasia-android-gestures-2.0.2.module | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2.module.md5 && \
	sha1sum trackasia-android-gestures-2.0.2.pom | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2.pom.sha1 && \
	sha1sum trackasia-android-gestures-2.0.2.aar | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2.aar.sha1 && \
	sha1sum trackasia-android-gestures-2.0.2.module | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2.module.sha1 && \
	sha1sum trackasia-android-gestures-2.0.2-sources.jar | cut -d ' ' -f 1 > trackasia-android-gestures-2.0.2-sources.jar.sha1

.PHONY: run-android-publish
run-android-publish:
	./gradlew :library:publishReleasePublicationToSonatypeRepository closeAndReleaseSonatypeStagingRepository