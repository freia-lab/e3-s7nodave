# Copyright (C) 2022  FREIA Laboratory

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


# The following lines are required
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS

# Most modules only need to be built for x86_64
ARCH_FILTER += linux-x86_64

# If your module has dependencies, you will generate want to include them like
#
#     REQUIRED += asyn
#     ifneq ($(strip $(ASYN_DEP_VERSION)),)
#       asyn_VERSION=$(ASYN_DEP_VERSION)
#     endif
#
# with $(ASYN_DEP_VERSION) defined in `configure/CONFIG_MODULE`

REQUIRED += asyn
ifneq ($(strip $(ASYN_DEP_VERSION)),)
  asyn_VERSION=$(ASYN_DEP_VERSION)
endif

# Since this file (s7nodave.Makefile) is copied into
# the module directory at build-time, these paths have to be relative
# to that path
APP := s7nodaveApp
APPDB := $(APP)/Db
APPSRC := $(APP)/src

# If you have files to include, you will generally want to include these, e.g.
#
#     SOURCES += $(APPSRC)/s7nodaveMain.cpp
#     SOURCES += $(APPSRC)/library.c
#     HEADERS += $(APPSRC)/library.h
#     USR_INCLUDES += -I$(where_am_I)$(APPSRC)

#SOURCES +=  $(wildcard $(APPSRC)/*.cc)
SOURCES +=  $(wildcard $(APPSRC)/../snap7/*.cpp)

SOURCES +=  $(APPSRC)/AnalogSupport.cc
SOURCES +=  $(APPSRC)/ArraySupport.cc
SOURCES +=  $(APPSRC)/BinarySupport.cc
SOURCES +=  $(APPSRC)/LongSupport.cc
SOURCES +=  $(APPSRC)/MultiBinarySupport.cc
SOURCES +=  $(APPSRC)/PlcAddress.cc
SOURCES +=  $(APPSRC)/PollGroup.cc
SOURCES +=  $(APPSRC)/PortDriver.cc
SOURCES +=  $(APPSRC)/PortDriverReadItem.cc
SOURCES +=  $(APPSRC)/PortDriverReadOptimizer.cc
SOURCES +=  $(APPSRC)/s7nodaveAsyn.cc
SOURCES +=  $(APPSRC)/S7nodaveInputRecord.cc
SOURCES +=  $(APPSRC)/S7nodaveOutputRecord.cc
SOURCES +=  $(APPSRC)/S7nodaveRecordAddress.cc
SOURCES +=  $(APPSRC)/S7nodaveRecord.cc
SOURCES +=  $(APPSRC)/StringSupport.cc
SOURCES +=  $(APPSRC)/utilities.cc

HEADERS +=  $(APPSRC)/AnalogSupport.h
HEADERS +=  $(APPSRC)/ArraySupport.h
HEADERS +=  $(APPSRC)/BinarySupport.h
HEADERS +=  $(APPSRC)/LongSupport.h
HEADERS +=  $(APPSRC)/MultiBinarySupport.h
HEADERS +=  $(APPSRC)/Optional.h
HEADERS +=  $(APPSRC)/PlcAddress.h
HEADERS +=  $(APPSRC)/PollGroup.h
HEADERS +=  $(APPSRC)/PortDriver.h
HEADERS +=  $(APPSRC)/PortDriverReadItem.h
HEADERS +=  $(APPSRC)/PortDriverReadOptimizer.h
HEADERS +=  $(APPSRC)/S7nodaveAaiRecord.h
HEADERS +=  $(APPSRC)/S7nodaveAaoRecord.h
HEADERS +=  $(APPSRC)/S7nodaveAiRecord.h
HEADERS +=  $(APPSRC)/S7nodaveAoRecord.h
HEADERS +=  $(APPSRC)/s7nodaveAsyn.h
HEADERS +=  $(APPSRC)/S7nodaveBiRecord.h
HEADERS +=  $(APPSRC)/S7nodaveBoRecord.h
HEADERS +=  $(APPSRC)/s7nodave.h
HEADERS +=  $(APPSRC)/S7nodaveInputRecord.h
HEADERS +=  $(APPSRC)/S7nodaveLonginRecord.h
HEADERS +=  $(APPSRC)/S7nodaveLongoutRecord.h
HEADERS +=  $(APPSRC)/S7nodaveMbbiDirectRecord.h
HEADERS +=  $(APPSRC)/S7nodaveMbbiRecord.h
HEADERS +=  $(APPSRC)/S7nodaveMbboDirectRecord.h
HEADERS +=  $(APPSRC)/S7nodaveMbboRecord.h
HEADERS +=  $(APPSRC)/S7nodaveOutputRecord.h
HEADERS +=  $(APPSRC)/S7nodaveRecordAddress.h
HEADERS +=  $(APPSRC)/S7nodaveRecord.h
HEADERS +=  $(APPSRC)/S7nodaveStringinRecord.h
HEADERS +=  $(APPSRC)/S7nodaveStringoutRecord.h
HEADERS +=  $(APPSRC)/S7nodaveWaveformInRecord.h
HEADERS +=  $(APPSRC)/S7nodaveWaveformOutRecord.h
HEADERS +=  $(APPSRC)/StringSupport.h
HEADERS +=  $(APPSRC)/utilities.h



USR_INCLUDES += -I$(where_am_I)$(APPSRC)/../snap7

DBDS += $(APPSRC)/s7nodave.dbd

TEMPLATES += $(wildcard $(APPDB)/*.db)
TEMPLATES += $(wildcard $(APPDB)/*.proto)
TEMPLATES += $(wildcard $(APPDB)/*.template)

SCRIPTS += $(wildcard ../iocsh/*.iocsh)

# Same as with any source or header files, you can also use $SUBS and $TMPS to define
# database files to be inflated (using MSI), e.g.
#
#     SUBS = $(wildcard $(APPDB)/*.substitutions)
#     TMPS = $(wildcard $(APPDB)/*.template)

USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(APPDB)

.PHONY: vlibs
vlibs:
