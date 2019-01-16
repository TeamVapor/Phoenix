import qbs
Project{
    Product{

        type:["cppheaders","cppsource"]
        name:"phoenix_consumer"
        Depends{name:"cpp"}
        cpp.defines:['PHOENIX_CONSUMER']
        Group  {
            name: "cppheaders"
            files: [
                "audiobuffer.h",
                "audiooutput.h",
                "videooutput.h",
                "videooutputnode.h",
            ]
        }
        Group  {
            name: "cppsource"
            files: [
                "audiobuffer.cpp",
                "audiooutput.cpp",
                "videooutput.cpp",
                "videooutputnode.cpp",
            ]
        }
    }
}
