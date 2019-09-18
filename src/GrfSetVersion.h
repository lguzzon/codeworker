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

#ifndef _GrfSetVersion_h_
#define _GrfSetVersion_h_

#include "GrfCommand.h"

namespace CodeWorker
{
class ExprScriptExpression;

class GrfSetVersion : public GrfCommand
{
private:
    ExprScriptExpression* _pVersion;

public:
    GrfSetVersion() : _pVersion(NULL) {}
    virtual ~GrfSetVersion();

    virtual const char* getFunctionName() const
    {
        return "setVersion";
    }

    inline void setVersion(ExprScriptExpression* pVersion)
    {
        _pVersion = pVersion;
    }

    virtual void compileCpp(CppCompilerEnvironment& theCompilerEnvironment) const;

protected:
    virtual SEQUENCE_INTERRUPTION_LIST executeInternal(DtaScriptVariable& visibility);
};
}

#endif
