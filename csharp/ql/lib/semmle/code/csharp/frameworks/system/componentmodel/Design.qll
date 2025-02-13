/** Provides definitions related to the `System.ComponentModel.Design` namespace. */

private import semmle.code.csharp.dataflow.ExternalFlow

/** Data flow for `System.ComponentModel.Design.DesignerCollectionService`. */
private class SystemComponentModelDesignDesignerCollectionServiceFlowModelCsv extends SummaryModelCsv {
  override predicate row(string row) {
    row =
      [
        "System.ComponentModel.Design;DesignerOptionService+DesignerOptionCollection;false;get_Item;(System.Int32);;Argument[this].Element;ReturnValue;value;manual",
        "System.ComponentModel.Design;DesignerOptionService+DesignerOptionCollection;false;get_Item;(System.String);;Argument[this].Element;ReturnValue;value;manual",
      ]
  }
}

/** Data flow for `System.ComponentModel.Design.DesignerVerbCollection`. */
private class SystemComponentModelDesignDesignerVerbCollectionFlowModelCsv extends SummaryModelCsv {
  override predicate row(string row) {
    row =
      [
        "System.ComponentModel.Design;DesignerVerbCollection;false;Add;(System.ComponentModel.Design.DesignerVerb);;Argument[0];Argument[this].Element;value;manual",
        "System.ComponentModel.Design;DesignerVerbCollection;false;AddRange;(System.ComponentModel.Design.DesignerVerbCollection);;Argument[0].Element;Argument[this].Element;value;manual",
        "System.ComponentModel.Design;DesignerVerbCollection;false;AddRange;(System.ComponentModel.Design.DesignerVerb[]);;Argument[0].Element;Argument[this].Element;value;manual",
        "System.ComponentModel.Design;DesignerVerbCollection;false;CopyTo;(System.ComponentModel.Design.DesignerVerb[],System.Int32);;Argument[this].Element;Argument[0].Element;value;manual",
        "System.ComponentModel.Design;DesignerVerbCollection;false;Insert;(System.Int32,System.ComponentModel.Design.DesignerVerb);;Argument[1];Argument[this].Element;value;manual",
        "System.ComponentModel.Design;DesignerVerbCollection;false;get_Item;(System.Int32);;Argument[this].Element;ReturnValue;value;manual",
        "System.ComponentModel.Design;DesignerVerbCollection;false;set_Item;(System.Int32,System.ComponentModel.Design.DesignerVerb);;Argument[1];Argument[this].Element;value;manual",
      ]
  }
}

/** Data flow for `System.ComponentModel.Design.DesignerCollection`. */
private class SystemComponentModelDesignDesignerCollectionFlowModelCsv extends SummaryModelCsv {
  override predicate row(string row) {
    row =
      "System.ComponentModel.Design;DesignerCollection;false;GetEnumerator;();;Argument[this].Element;ReturnValue.Property[System.Collections.IEnumerator.Current];value;manual"
  }
}
