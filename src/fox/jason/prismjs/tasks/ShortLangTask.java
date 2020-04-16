/*
 *  This file is part of the DITA-OT Prism-JS Plug-in project
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.prismjs.tasks;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

//
// Obtains the corrected highlighting language from the outputclass
//

public class ShortLangTask extends Task {

  /**
   * Field outputclass.
   */
  private String outputclass;

  /**
   * Field property.
   */
  private String property;

  /**
   * Field regex.
   */
  private Pattern regex;

  /**
   * Creates a new <code>ShortLangTask</code> instance.
   */
  public ShortLangTask() {
    super();
    this.outputclass = null;
    this.property = null;
    this.regex = Pattern.compile("\\blang(?:uage)?-([\\w-]+)\\b", Pattern.CASE_INSENSITIVE);
  }

  /**
   * Method setOutputclass.
   *
   * @param outputclass String
   */
  public void setOutputclass(String outputclass) {
    this.outputclass = outputclass;
  }

  /**
   * Method setProperty.
   *
   * @param property String
   */
  public void setProperty(String property) {
    this.property = property;
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    //  @param  outputclass -   The outputclass of the codeblock
    //  @param  property -      The property to set with the corrected 
    //                          highighting language
    if (outputclass == null) {
      throw new BuildException("You must supply an outputclass");
    }
    if (property == null) {
      throw new BuildException("You must supply a property to set");
    }


    String language = outputclass.toLowerCase();
    Matcher matcher = regex.matcher(outputclass);
    while (matcher.find()) {
      language = matcher.group();
      language = language.substring(language.indexOf('-') + 1, language.length());
      break;
    }
    getProject().setProperty(property, language);
  }
}