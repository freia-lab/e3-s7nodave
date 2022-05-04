# This should be a test or example startup script

require s7nodave

s7nodaveConfigureIsoTcpPort("cowPLC", "192.168.1.70",0,0,0)

#dbLoadRecords("$(s7nodave_DB)/example.db", "P=test")
dbLoadRecords("$(s7nodave_DB)/lo-update.template", "P=test:, R='',S=ctest, OUT='cowPLC DB3010.DBW132 uint16'")
dbLoadRecords("$(s7nodave_DB)/ao-update.template", "P=test:, R='',S=catest, OUT='cowPLC DB3010.DBD170 float'")

