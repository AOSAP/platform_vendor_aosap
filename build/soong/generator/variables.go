package generator

import (
	"fmt"

	"android/soong/android"
)

func aosapExpandVariables(ctx android.ModuleContext, in string) string {
	aosapVars := ctx.Config().VendorConfig("aosapVarsPlugin")

	out, err := android.Expand(in, func(name string) (string, error) {
		if aosapVars.IsSet(name) {
			return aosapVars.String(name), nil
		}
		// This variable is not for us, restore what the original
		// variable string will have looked like for an Expand
		// that comes later.
		return fmt.Sprintf("$(%s)", name), nil
	})

	if err != nil {
		ctx.PropertyErrorf("%s: %s", in, err.Error())
		return ""
	}

	return out
}
