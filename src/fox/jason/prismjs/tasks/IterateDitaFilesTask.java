/*
 *  This file is part of the DITA-OT Pretty DITA Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.prismjs.tasks;

import java.util.ArrayList;
import java.util.List;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.taskdefs.MacroInstance;
import org.apache.tools.ant.types.FileSet;

//
//    Iterator function to run a given macro against a set of files
//

public class IterateDitaFilesTask extends Task {

  /**
   * Field list.
   */
  private String list;
  /**
   * Field macro.
   */
  private String macro;

  /**
   * Creates a new <code>IterateDitaFilesTask</code> instance.
   */
  public IterateDitaFilesTask() {
    super();
    this.list = null;
    this.macro = null;
  }

  /**
   * Method setList.
   *
   * @param list String
   */
  public void setList(String list) {
    this.list = list;
  }

  /**
   * Method setMacro.
   *
   * @param macro String
   */
  public void setMacro(String macro) {
    this.macro = macro;
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    //    @param list - The list of files to annotate
    if (this.list == null) {
      throw new BuildException("You must supply a list of files to annotate");
    }
    if (this.macro == null) {
      throw new BuildException("You must supply a macro");
    }

    String[] filenames = list.split(";", 0);
  
    for (String file : filenames) {

       MacroInstance task = (MacroInstance) getProject()
          .createTask(this.macro);
        try {
          task.setDynamicAttribute("file", file);
          task.execute();
        } catch (Exception err) {
          throw new BuildException(err);
        }
    }
  }
}
