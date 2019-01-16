import qbs
Project{
    Product{
        type:["dynamiclibrary","prheaders","puheaders"]
        name:"util"


        Depends{name:'cpp'}
        Depends{name:  "Qt"; submodules:["core","core-private"]}

        cpp.defines:['PHOENIX_UTIL']


        Group {
            qbs.install: true
            fileTagsFilter: "dynamiclibrary"
            qbs.installDir: "/lib"
        }
    }
}
