include(ExternalProject)
include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(p7_source
	URL http://baical.net/files/libP7Client_v5.4.zip
	URL_HASH SHA256=a7d6362a984d45ebb63d74c825085c1dfd7e9fbcb09ebaeb765cb97c42ab98ec
)

FetchContent_GetProperties(p7_source)
if(NOT p7_source_POPULATED)
	FetchContent_Populate(p7_source)
	add_library(P7 STATIC "")
	target_sources(P7
		PRIVATE
			${p7_source_SOURCE_DIR}/Sources/ClBaical.cpp
			${p7_source_SOURCE_DIR}/Sources/ClFile.cpp
			${p7_source_SOURCE_DIR}/Sources/Client.cpp
			${p7_source_SOURCE_DIR}/Sources/ClNull.cpp
			${p7_source_SOURCE_DIR}/Sources/ClText.cpp
			${p7_source_SOURCE_DIR}/Sources/CRC32.cpp
			${p7_source_SOURCE_DIR}/Sources/Proxy.cpp
			${p7_source_SOURCE_DIR}/Sources/Telemetry.cpp
			${p7_source_SOURCE_DIR}/Sources/Trace.cpp

			${p7_source_SOURCE_DIR}/Sources/ClBaical.h
			${p7_source_SOURCE_DIR}/Sources/ClFile.h
			${p7_source_SOURCE_DIR}/Sources/Client.h
			${p7_source_SOURCE_DIR}/Sources/ClNull.h
			${p7_source_SOURCE_DIR}/Sources/ClTextConsole.h
			${p7_source_SOURCE_DIR}/Sources/ClTextFile.h
			${p7_source_SOURCE_DIR}/Sources/ClText.h
			${p7_source_SOURCE_DIR}/Sources/ClTextSink.h
			${p7_source_SOURCE_DIR}/Sources/ClTextSyslog.h
			${p7_source_SOURCE_DIR}/Sources/CommonClient.h
			${p7_source_SOURCE_DIR}/Sources/Common.h
			${p7_source_SOURCE_DIR}/Sources/Formatter.h
			${p7_source_SOURCE_DIR}/Sources/PacketsPool.h
			${p7_source_SOURCE_DIR}/Sources/resource.h
			${p7_source_SOURCE_DIR}/Sources/targetver.h
			${p7_source_SOURCE_DIR}/Sources/Telemetry.h
			${p7_source_SOURCE_DIR}/Sources/TPackets.h
			${p7_source_SOURCE_DIR}/Sources/Trace.h

		PUBLIC
			${p7_source_SOURCE_DIR}/Headers/GTypes.h
			${p7_source_SOURCE_DIR}/Headers/P7_Client.h
			${p7_source_SOURCE_DIR}/Headers/P7_Cproxy.h
			${p7_source_SOURCE_DIR}/Headers/P7_Extensions.h
			${p7_source_SOURCE_DIR}/Headers/P7_Telemetry.h
			${p7_source_SOURCE_DIR}/Headers/P7_Trace.h
			${p7_source_SOURCE_DIR}/Headers/P7_Version.h

			${p7_source_SOURCE_DIR}/Shared/AList.h
			${p7_source_SOURCE_DIR}/Shared/CRC32.h
			${p7_source_SOURCE_DIR}/Shared/DnsResolver.h
			${p7_source_SOURCE_DIR}/Shared/IConsole.h
			${p7_source_SOURCE_DIR}/Shared/IFile.h
			${p7_source_SOURCE_DIR}/Shared/IJournal.h
			${p7_source_SOURCE_DIR}/Shared/IMEvent.h
			${p7_source_SOURCE_DIR}/Shared/IPerformanceInfo.h
			${p7_source_SOURCE_DIR}/Shared/ISignal.h
			${p7_source_SOURCE_DIR}/Shared/Length.h
			${p7_source_SOURCE_DIR}/Shared/Lock.h
			${p7_source_SOURCE_DIR}/Shared/Predicate.h
			${p7_source_SOURCE_DIR}/Shared/QStringHelper.h
			${p7_source_SOURCE_DIR}/Shared/RBTree.h
			${p7_source_SOURCE_DIR}/Shared/SharedLib.h
			${p7_source_SOURCE_DIR}/Shared/Ticks.h
			${p7_source_SOURCE_DIR}/Shared/UDP_NB.h
			${p7_source_SOURCE_DIR}/Shared/UTF.h
			${p7_source_SOURCE_DIR}/Shared/WString.h
	)
	target_include_directories(P7
		PUBLIC
			${p7_source_SOURCE_DIR}/Shared
			${p7_source_SOURCE_DIR}/Headers
	)

	if(WIN32)
		target_sources(P7
			PUBLIC
				${p7_source_SOURCE_DIR}/Sources/P7Client.rc

				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PAtomic.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PConsole.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PCRC32.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PDnsTxtResolver.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PFile.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PFileSystem.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PJournal.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PLock.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PMEvent.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PPerformanceInfo.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PProcess.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PShared.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PSharedLib.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PSignal.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PSocket.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PString.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PSystem.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PThreadShell.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86/PTime.h
		)
		target_include_directories(P7
			PUBLIC
				${p7_source_SOURCE_DIR}/Shared/Platforms/Windows_x86
		)
		target_link_libraries(P7
			PUBLIC
				ws2_32
		)
	else()
		target_sources(P7
			PUBLIC
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PAtomic.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PConsole.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PCrashDump.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PCRC32.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PDnsTxtResolver.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PFile.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PFileSystem.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PJournal.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PLock.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PMEvent.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PPerformanceInfo.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PProcess.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PProfiler.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PShared.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PSharedLib.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PSignal.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PSocket.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PString.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PSystem.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PThreadShell.h
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86/PTime.h
		)

		target_include_directories(P7
			PUBLIC
				${p7_source_SOURCE_DIR}/Shared/Platforms/Linux_x86
		)
		target_link_libraries(P7
			PUBLIC
				pthread
				rt
		)
	endif()

	add_executable(P7_CPP_Example ${p7_source_SOURCE_DIR}/Examples/Cpp/Main.cpp)
	target_link_libraries(P7_CPP_Example P7)

	add_executable(P7_C_Example ${p7_source_SOURCE_DIR}/Examples/C/C_Example.c)
	target_link_libraries(P7_C_Example P7)

	add_executable(P7_Test_Speed ${p7_source_SOURCE_DIR}/Tests/Speed/Speed.cpp)
	target_link_libraries(P7_Test_Speed P7)

	add_executable(P7_Test_Trace ${p7_source_SOURCE_DIR}/Tests/Trace/Main.cpp)
	target_link_libraries(P7_Test_Trace P7)
endif()