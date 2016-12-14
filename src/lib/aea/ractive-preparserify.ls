require! 'through2': through
require! <[ pug path cheerio fs ]>
require! 'ractive':Ractive
require! 'prelude-ls': {map}

/*******************************************************************************

USAGE:

Replace `template: '#my-template'` with
    * `template: RACTIVE_PREPARSE('my-template.pug')` if file contains only template code
    * `template: RACTIVE_PREPARSE('my-template.pug', '#some-template-id')` if file contains multiple template codes

Example:

    In the main ractive instance:

        ractive = new Ractive do
            el: '#main-output'
            template: RACTIVE_PREPARSE('base.pug')


    In a component file:

        Ractive.components.checkbox = Ractive.extend do
            template: RACTIVE_PREPARSE('index.pug')
            isolated: yes
            oninit: ->

********************************************************************************/

module.exports = (file) ->
    through (buf, enc, next) ->
        __ = this
        content = buf.to-string \utf8
        dirname = path.dirname file
        preparse-jade = (m, params-str) ->
            [template-file, template-id] = params-str.split ',' |> map (.replace /["'\s]+/g, '')

            ext = path.extname template-file
            template-full-path = path.join dirname, template-file
            template-contents = fs.read-file-sync template-full-path .to-string!

            if ext is \.html
                template-html = template-contents
            else if ext is \.pug
                try
                    # include templates/mixins.pug file
                    mixin-relative = path.relative dirname, process.cwd!
                    mixin-include = "include #{mixin-relative}/src/client/templates/mixins.pug\n"
                    template-contents = mixin-include + template-contents
                    fn = pug.compile template-contents, {filename: file}
                    template-html = fn!
                catch _ex
                    e = {}
                    #console.error "ERROR: ractive-parserify: #{e}"
                    e.name = 'Ractive Preparse Error'
                    e.message = _ex.message
                    e.fileName = template-full-path
                    console.log "cwd: ", process.cwd!
                    console.log "err file: ", template-full-path
                    __.emit 'error', _ex.message
                    return



            template-part = if template-id
                $ = cheerio.load template-html
                try
                    $ template-id .html!
                catch
                    console.error "ERROR: ractive-preparserify: can not get template id: #{template-id} from ", html
                    ''
            else
                template-html

            # Debug
            #console.log "DEBUG: ractive-preparsify: compiling template: #{path.basename path.dirname file}/#{jade-file} #{template-id or \ALL_HTML }"
            # End of debug

            parsed-template = Ractive.parse template-part
            JSON.stringify parsed-template

        this.push(content.replace /RACTIVE_PREPARSE\(([^\)]+)\)/g, preparse-jade)
        next!