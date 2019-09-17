/* "CodeWorker":	a scripting language for parsing and generating text.

Copyright (C) 1996-1997, 1999-2010 C�dric Lemaire

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

To contact the author: codeworker@free.fr
*/

#ifdef WIN32
#pragma warning(disable : 4786)
#endif

#include "GrfRemoveElement.h"
#include "CGRuntime.h"
#include "CppCompilerEnvironment.h"
#include "DtaScriptVariable.h"
#include "ExprScriptExpression.h"
#include "ExprScriptVariable.h"
#include "ScpStream.h"
#include <string>

namespace CodeWorker {
GrfRemoveElement::~GrfRemoveElement()
{
  delete _pVariable;
  delete _pKey;
}

SEQUENCE_INTERRUPTION_LIST
GrfRemoveElement::executeInternal(DtaScriptVariable& visibility)
{
  DtaScriptVariable* pVariable = visibility.getExistingVariable(*_pVariable);
  std::string sKey = _pKey->getValue(visibility);
  return CGRuntime::removeElement(pVariable, sKey);
}

void
GrfRemoveElement::compileCpp(
  CppCompilerEnvironment& theCompilerEnvironment) const
{
  CW_BODY_INDENT << "CGRuntime::removeElement(";
  _pVariable->compileCpp(theCompilerEnvironment);
  CW_BODY_STREAM << ", ";
  _pKey->compileCppString(theCompilerEnvironment);
  CW_BODY_STREAM << ");";
  CW_BODY_ENDL;
}
}
