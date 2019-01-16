import qbs
Project{
    Product{
        type:["dynamiclibrary","prheaders","puheaders"]
        name:"core"


        Depends{name:'cpp'}
        Depends{name:  "Qt"; submodules:["core","core-private"]}

        cpp.defines:['PHOENIX_CORE']


        Group {
            qbs.install: true
            fileTagsFilter: "dynamiclibrary"
            qbs.installDir: "/lib"
        }
    }
}

