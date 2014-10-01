within ;
package Lib "Library for crash course Modelica and IDEAS"
  extends Modelica.Icons.Package;
  import IDEAS;


  annotation (uses(                         IDEAS(version="2"), Modelica(
        version="3.2.1")),
    version="1",
    conversion(noneFromVersion=""));
end Lib;
