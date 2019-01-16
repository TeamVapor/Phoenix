import qbs
Project{
    Product{

        type:["cppheaders","cppsource"]
        name:"phoenix_control"
        Depends{name:"cpp"}
        cpp.defines:['PHOENIX_CONSUMER']
        cpp.includePaths:[""]
        Group  {
            name: "cppheaders"
            files: [
                "controloutput.h",
                "gameconsole.h",
            ]
        }
        Group  {
            name: "cppsource"
            files: [
                "controloutput.cpp",
                "gameconsole.cpp",
            ]
        }
    }
}
