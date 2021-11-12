# lazy_load_indexed_stack

A package that extends IndexedStack to allow for lazy loading.

## Motivation

If you use the IndexedStack with bottom navigation, all the widgets specified in the children of the IndexedStack will be built.

Moreover, if the widget requires API requests or database access, or has a complex UI, the IndexedStack build time will be significant.

Therefore, I created an extended IndexedStack that builds the required widget only when it is needed, and returns the pre-built widget when it is needed again.
