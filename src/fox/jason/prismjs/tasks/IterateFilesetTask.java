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

public class IterateFilesetTask extends Task {
  /**
   * Field filesets.
   */
  private List<FileSet> filesets;
  /**
   * Field macro.
   */
  private String macro;
  /**
   * Field file.
   */
  private String file;

  /**
   * Field dir.
   */
  private String dir;

  /**
   * Creates a new <code>IterateFilesetTask</code> instance.
   */
  public IterateFilesetTask() {
    super();
    this.dir = null;
    this.file = null;
    this.macro = null;
    this.filesets = new ArrayList<>();
  }

  /**
   * Method setDir.
   *
   * @param dir String
   */
  public void setDir(String dir) {
    this.dir = dir;
  }

  /**
   * Method setfile.
   *
   * @param file String
   */
  public void setFile(String file) {
    this.file = file;
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
   * @param set FileSet
   */
  public void addFileset(FileSet set) {
    this.filesets.add(set);
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    //    @param file - The output location of the files
    //    @param dir  - The location of the files to process
    //    @param macro - A macro to run.
    //    @param fileset - A set of files
    if (this.dir == null) {
      throw new BuildException("You must supply a source directory");
    }
    if (this.file == null) {
      throw new BuildException("You must supply a destination file");
    }
    if (this.macro == null) {
      throw new BuildException("You must supply a macro");
    }
    if (this.filesets.isEmpty()) {
      throw new BuildException("You must supply a set of files");
    }

    for (FileSet fileset : this.filesets) {
      DirectoryScanner scanner = fileset.getDirectoryScanner(getProject());
      scanner.scan();

      for (String src : scanner.getIncludedFiles()) {
        MacroInstance task = (MacroInstance) getProject()
          .createTask(this.macro);
        try {
          task.setDynamicAttribute("src", src);
          task.setDynamicAttribute("dir", this.dir);
          task.setDynamicAttribute("file", this.file);
          task.execute();
        } catch (Exception err) {
          throw new BuildException(err);
        }
      }
    }
  }
}
